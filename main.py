import logging
import os

logger = logging.getLogger()
logger.setLevel(logging.INFO)


def is_aws_env():
    return os.environ.get("AWS_LAMBDA_FUNCTION_NAME") or os.environ.get(
        "AWS_EXECUTION_ENV"
    )


def lambda_handler(event: dict = {}, context=None):
    logger.info("It works!")


if not is_aws_env():
    from rich.logging import RichHandler

    FORMAT = "%(message)s"
    logging.basicConfig(
        level="NOTSET", format=FORMAT, datefmt="[%X]", handlers=[RichHandler()]
    )

    logger = logging.getLogger("rich")
    lambda_handler({}, {})
