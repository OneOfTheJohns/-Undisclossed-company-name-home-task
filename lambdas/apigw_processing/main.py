# https://docs.aws.amazon.com/lambda/latest/dg/services-apigateway-tutorial.html

import boto3
import os
import calendar;
import time;
import json

table_name = os.environ["table_name"]

# Create the DynamoDB resource
dynamo = boto3.resource('dynamodb').Table(table_name)

### writing down the event into dynamodb
def create(body,id):
    print("******* CREATE *********")
    try: 
        dynamo.put_item(
            Item={
                "id": id,
                "body": body,
            }
        )
        answer = {"status": "healthy", "message": "Request processed and saved."}
        return answer
    except Exception as e:
        print(f"something broke {e}")

operations = {
    'create': create,
}

def lambda_handler(event, context):
    '''Provide an event that contains the following keys:
      - operation: one of the operations in the operations dict below
      - payload: a JSON object containing parameters to pass to the 
        operation being performed
    '''
    ###https://www.geeksforgeeks.org/python/get-current-timestamp-using-python/
    ### getting unique id
    gmt = time.gmtime()
    ts = str(calendar.timegm(gmt))
    print("timestamp:", ts)
    ### https://docs.aws.amazon.com/lambda/latest/dg/python-logging.html
    ### printing out the event to cloudwatch logs.
    print(event)
    ### checking if event contains proper key-name payload
    try:
        body=event["body"]
        id=ts
        create(body,id)
        # https://docs.aws.amazon.com/apigateway/latest/developerguide/set-up-lambda-proxy-integrations.html#api-gateway-simple-proxy-for-lambda-output-format
        return {
            "statusCode": 200,
            "headers": {
                "Content-Type": "application/json"
            },
            "body": "\"status\": \"healthy\", \"message\": \"Request processed and saved.\""
        }
    except:
        answer=400