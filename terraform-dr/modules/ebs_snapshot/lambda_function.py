import boto3
import datetime
import os

ec2 = boto3.client("ec2")

PROJECT_NAME = os.environ["PROJECT_NAME"]


def lambda_handler(event, context):

    print("===== CloudShield Snapshot Job =====")

    instances = ec2.describe_instances(

        Filters=[

            {

                "Name": "tag:Backup",

                "Values": ["Enabled"]

            },

            {

                "Name": "instance-state-name",

                "Values": ["running"]

            }

        ]

    )

    for reservation in instances["Reservations"]:

        for instance in reservation["Instances"]:

            instance_id = instance["InstanceId"]

            print(f"Processing {instance_id}")

            for device in instance["BlockDeviceMappings"]:

                if "Ebs" not in device:
                    continue

                volume_id = device["Ebs"]["VolumeId"]

                snapshot = ec2.create_snapshot(

                    VolumeId=volume_id,

                    Description=f"{PROJECT_NAME} Automated Snapshot"

                )

                snapshot_id = snapshot["SnapshotId"]

                print(f"Snapshot Created : {snapshot_id}")

                ec2.create_tags(

                    Resources=[snapshot_id],

                    Tags=[

                        {

                            "Key": "Project",

                            "Value": PROJECT_NAME

                        },

                        {

                            "Key": "CreatedBy",

                            "Value": "CloudShield-DR"

                        },

                        {

                            "Key": "RetentionDays",

                            "Value": "30"

                        }

                    ]

                )

    cutoff = datetime.datetime.now(datetime.UTC) - datetime.timedelta(days=30)

    snapshots = ec2.describe_snapshots(

        OwnerIds=["self"]

    )

    for snapshot in snapshots["Snapshots"]:

        tags = {

            tag["Key"]: tag["Value"]

            for tag in snapshot.get("Tags", [])

        }

        if tags.get("Project") != PROJECT_NAME:
            continue

        if tags.get("RetentionDays") != "30":
            continue

        if snapshot["StartTime"] < cutoff:

            print(f"Deleting Snapshot {snapshot['SnapshotId']}")

            ec2.delete_snapshot(

                SnapshotId=snapshot["SnapshotId"]

            )

    return {

        "statusCode": 200,

        "body": "Snapshot Job Completed"

    }