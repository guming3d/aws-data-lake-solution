export AWS_REGION=cn-north-1
export VERSION_CODE=v2.3
export DEPLOY_BUCKET=datalake-cn-deploy
export SOLUTION_NAME=datalake-cn

#./build-s3-dist.sh solutions trademarked-solution-name v1.0.0 cf-template-bucket"
./build-s3-dist.sh $SOLUTION_NAME $SOLUTION_NAME $VERSION_CODE $DEPLOY_BUCKET
