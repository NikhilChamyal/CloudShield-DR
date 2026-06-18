import boto3
import json
import os

ec2 = boto3.client("ec2")

INSTANCE_ID = os.environ["INSTANCE_ID"]


def lambda_handler(event, context):

    print(json.dumps(event))

    try:

        message = json.loads(event["Records"][0]["Sns"]["Message"])

        alarm_state = message.get("NewStateValue", "")

        alarm_name = message.get("AlarmName", "")

        print(f"Alarm: {alarm_name}")
        print(f"State: {alarm_state}")

        if alarm_state != "ALARM":

            print("Alarm is not in ALARM state. Nothing to do.")

            return {
                "statusCode": 200,
                "body": "No recovery required."
            }

        ec2.reboot_instances(
            InstanceIds=[INSTANCE_ID]
        )

        print(f"Recovery initiated for {INSTANCE_ID}")

        return {
            "statusCode": 200,
            "body": "Recovery started."
        }

    except Exception as e:

        print(str(e))

        raise e