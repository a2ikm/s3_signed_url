require "uri"
require "aws-sdk"

module S3SharedUpload
  class Cli
    attr_reader :path, :s3_uri, :options

    def initialize(path, s3_url, options = {})
      @path = File.expand_path(path)
      @s3_uri = URI(s3_url)
      @options = options
    end

    def run
      upload
      presigned_url = generate_presigned_url

      puts presigned_url
    end

    private

    def upload
      client.put_object(
        bucket: bucket_name,
        body: object_body,
        key: object_key
      )
    end

    def generate_presigned_url
      signer.presigned_url(
        :get_object,
        bucket: bucket_name,
        key: object_key
      )
    end

    def signer
      @signer ||= Aws::S3::Presigner.new(client: client)
    end

    def client
      @client ||= Aws::S3::Client.new
    end

    def bucket_name
      @s3_uri.host
    end

    def object_key
      @s3_uri.path
    end

    def object_body
      File.read(path)
    end
  end
end
