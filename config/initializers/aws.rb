# require 'aws-sdk'
# Aws.config(
#   :access_key_id => ENV['AWS_ACCESS_KEY_ID'],
#   :secret_access_key => ENV['AWS_SECRET_ACCESS_KEY']
# )

# S3_BUCKET =  Aws::S3.new.buckets[ENV['S3_BUCKET']]

# Aws.config.update({
#    credentials: Aws::Credentials.new(ENV['AWS_ACCESS_KEY_ID'], ENV['AWS_SECRET_ACCESS_KEY']),
#    region: ENV['AWS_REGION']
# })

# S3_BUCKET = Aws::S3::Resource.new.bucket(ENV['S3_BUCKET'])
# Aws.config.update({
#    credentials: Aws::Credentials.new('your_access_key_id', 'your_secret_access_key')
# })
# s3 = Aws::S3::Client.new(
#   access_key_id: ENV['AWS_ACCESS_KEY_ID'],
#   secret_access_key: ENV['AWS_SECRET_ACCESS_KEY']

# )

Aws.config.update({
   credentials: Aws::Credentials.new(ENV['AWS_ACCESS_KEY_ID'], ENV['AWS_SECRET_ACCESS_KEY']),
   region: 'us-west-2'
})

S3_BUCKET = Aws::S3::Resource.new.bucket(ENV['S3_BUCKET'])
puts ENV['S3_BUCKET']