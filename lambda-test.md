Create an api gateway that routes GET requests to a lambda and the lambda function that handles it.

The requests will have the following query string structure:

operation: addition, subtraction, multiplication or division
first: first number of the operation, always integer
second: second number of the operation, always integer
If all components on the query string are valid, return a 200OK with the operation result on body: Example: $ curl -XGET 'https://ashd8e41f.execute-api.eu-west-1.amazonaws.com/?operation=subtraction&first=3&second=17' -14

If the request is invalid, return appropriate error code (4XX/5XX) - this doesn't need to be complex.

Use AWS technologies (SAM/SAM local, CloudFormation, CDK etc) for development. 

Document or provide link for deployment and/or local testing.
