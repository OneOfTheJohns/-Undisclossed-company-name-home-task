terraform {
    source = "../../terraform-modules/lambda"
}

inputs = {
    path_to_lambda = "../../../lambdas/apigw_processing/file.zip"
}