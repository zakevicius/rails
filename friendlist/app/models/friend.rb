# frozen_string_literal: true

class Friend < ApplicationRecord
  belongs_to :user
  after_create :upload_to_s3
  before_destroy :move_to_other_bucket
  
  def encrypt_data
    AwsLambdaService.new(region: 'eu-north-1').invoke(
      'CGCrypt',
      {
        bucket: 'test-m-photo',
        key: key,
        type: 'encrypt'
      }
    )
  end

  def decrypt_data
    AwsLambdaService.new(region: 'eu-north-1').invoke(
      'CGCrypt',
      {
        bucket: 'kms-test-m',
        key: key,
        type: 'decrypt'
      }
    )
  end

  private

  def upload_to_s3
    data = {
      first_name: first_name,
      last_name: last_name
    }

    AwsS3Service.new(region: 'eu-north-1').upload_file(data, filename, key)
  end

  def move_to_other_bucket
    AwsLambdaService.new(region: 'eu-north-1').invoke(
      'CGCrypt',
      {
        bucket: 'test-m-photo',
        key: key
      }
    )
  end


  def key
    @key ||= "friends/#{id}/#{filename}"
  end

  def filename
    @filename ||= "#{first_name}.json"
  end
end
