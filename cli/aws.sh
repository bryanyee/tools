### aws s3 CLI

# Show s3 files:
aws s3 ls
aws s3 ls <bucket>
aws s3 ls --recursive <bucket>

# Create an s3 bucket:
aws s3 mb s3://mybucket

# Copy a local file to an s3 object:
aws s3 cp test.txt s3://mybucket/test.txt

# Copy a local directory to an s3 bucket:
aws s3 cp <directory_path> s3://<bucket_name>

# Copy an s3 object to a local file:
aws s3 cp s3://mybucket/test.txt test2.txt

# Copy an s3 bucket to a local directory:
aws s3 cp s3://mybucket . --recursive

# Copy an s3 object to another s3 location:
aws s3 cp s3://mybucket/test.txt s3://anotherbucket/test.txt

# Remove an s3 file:
aws s3 rm s3://mybucket/test.txt test2.txt



### aws s3api CLI

# Show s3api commands:
aws s3api help

# Check if a bucket exists (no output if the bucket exists and you have permissions):
aws s3api head-bucket --bucket <bucket>

# Get metadata about an s3 file:
aws s3api head-object --bucket <bucket> --key <object_path>
aws s3api head-object --bucket my_bucket --key object_path
aws s3api head-object --bucket grnds-uat-brizo-databases --key index.html

# List s3 files and metadata:
aws s3api list-objects --bucket <bucket>

# Copy an s3 object to a local file:
aws s3api get-object --bucket <bucket> --key <object_path> <local_copy>
aws s3api get-object --bucket my_bucket --key object_path.json local_file.json

# Get the policy of a bucket:
aws s3api get-bucket-policy --bucket <bucket>

# Create an s3 bucket:
aws s3api create-bucket --bucket my-bucket
