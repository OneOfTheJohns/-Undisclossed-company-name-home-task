# https://docs.aws.amazon.com/lambda/latest/dg/services-apigateway-tutorial.html

import boto3
import os

table_name = os.environ["table_name"]

# Create the DynamoDB resource
dynamo = boto3.resource('dynamodb').Table(table_name)

### writing down the event into dynamodb
def create(key,name):
    try: 
        dynamo.put_item(key=name)
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
    ### https://docs.aws.amazon.com/lambda/latest/dg/python-logging.html
    ### printing out the event to cloudwatch logs.
    print(event)
    ### checking if event contains proper key-name payload
    try:
        key=event["key"]
        name=event["name"]
        create(key,name)
    except:
        answer=400
    return answer