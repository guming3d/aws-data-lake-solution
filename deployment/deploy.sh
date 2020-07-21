export AWS_REGION=cn-north-1
export VERSION_CODE=v2.3
export DEPLOY_BUCKET=datalake-cn-deploy
export SOLUTION_NAME=datalake-cn

aws s3api delete-bucket --bucket datalake-cn-852226251499-cn-north-1-s3-access-log --region cn-north-1
aws cloudformation delete-stack --stack-name AWSDataLake

#./build-s3-dist.sh solutions trademarked-solution-name v1.0.0 cf-template-bucket"
./build-s3-dist.sh $SOLUTION_NAME $SOLUTION_NAME $VERSION_CODE $DEPLOY_BUCKET

aws s3 cp ./regional-s3-assets s3://$DEPLOY_BUCKET/datalake-cn/$VERSION_CODE --recursive --acl bucket-owner-full-control
aws s3 cp ./global-s3-assets s3://$DEPLOY_BUCKET/datalake-cn/$VERSION_CODE --recursive --acl bucket-owner-full-control



sleep  10

aws cloudformation create-stack --stack-name AWSDataLake --template-body file:///home/minggu/code/aws-data-lake-solution/deployment/global-s3-assets/data-lake-deploy.template --parameters '[{"ParameterKey":"AdministratorName","ParameterValue":"minggu"}, {"ParameterKey":"AdministratorEmail","ParameterValue":"minggu@amazon.com"}, {"ParameterKey":"CognitoDomain","ParameterValue":"datalake-cn"}]' --capabilities CAPABILITY_NAMED_IAM

