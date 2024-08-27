data "aws_iam_policy_document" "assume_role" {
  statement {
    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["lambda.amazonaws.com"]
    }

    actions = ["sts:AssumeRole"]
  }
}

resource "aws_iam_role" "iam_for_lambda" {
  name               = "iam_for_lambda"
  assume_role_policy = data.aws_iam_policy_document.assume_role.json
}

# data "archive_file" "lambda" {
#   type        = "zip"
#   source_file = "lunch_calendar.zip"
#   output_path = "lambda_function_payload.zip"
# }

resource "aws_lambda_function" "lunch_calendar" {
  # If the file is not in the current working directory you will need to include a
  # path.module in the filename.
  filename      = "school_calendar.zip"
  function_name = "school_calendar"
  role          = aws_iam_role.iam_for_lambda.arn
  handler       = "main.handler"

  #source_code_hash = data.archive_file.lambda.output_base64sha256

  runtime = "python3.12"

  environment {
    variables = {
      foo = "bar"
    }
  }
}
