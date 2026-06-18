import boto3
import datetime
import os

rds = boto3.client("rds")

PROJECT_NAME = os.environ["PROJECT_NAME"]
DB_IDENTIFIER = os.environ["DB_IDENTIFIER"]


def lambda_handler(event, context):

    print("===== CloudShield RDS Snapshot Job =====")

    snapshot_id = f"{DB_IDENTIFIER}-{datetime.datetime.utcnow().strftime('%Y%m%d%H%M%S')}"

    response = rds.create_db_snapshot(
        DBSnapshotIdentifier=snapshot_id,
        DBInstanceIdentifier=DB_IDENTIFIER
    )

    snapshot_arn = response["DBSnapshot"]["DBSnapshotArn"]

    rds.add_tags_to_resource(
        ResourceName=snapshot_arn,
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

    print(f"Snapshot Created : {snapshot_id}")

    cutoff = datetime.datetime.utcnow() - datetime.timedelta(days=30)

    snapshots = rds.describe_db_snapshots(
        DBInstanceIdentifier=DB_IDENTIFIER,
        SnapshotType="manual"
    )

    for snapshot in snapshots["DBSnapshots"]:

        snapshot_time = snapshot["SnapshotCreateTime"].replace(tzinfo=None)

        if snapshot_time > cutoff:
            continue

        arn = snapshot["DBSnapshotArn"]

        tags = rds.list_tags_for_resource(
            ResourceName=arn
        )["TagList"]

        tag_map = {tag["Key"]: tag["Value"] for tag in tags}

        if tag_map.get("Project") != PROJECT_NAME:
            continue

        if tag_map.get("RetentionDays") != "30":
            continue

        print(f"Deleting Snapshot : {snapshot['DBSnapshotIdentifier']}")

        rds.delete_db_snapshot(
            DBSnapshotIdentifier=snapshot["DBSnapshotIdentifier"]
        )

    return {
        "statusCode": 200,
        "body": "RDS Snapshot Job Completed"
    }