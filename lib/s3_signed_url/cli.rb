require "uri"
require "aws-sdk"

module S3SignedUrl
  class Cli
    attr_reader :s3_uri, :options

    def initialize(s3_url, options = {})
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
      return unless options.key?(:upload)

      path = options[:upload]
      object_body = File.read(File.expand_path(path))

      client.put_object(
        bucket: bucket_name,
        body: object_body,
        key: object_key
      )
    end

    def generate_presigned_url
      opts = {
        bucket: bucket_name,
        key: object_key,
        secure: options[:secure]
      }

      opts[:expires_in] = options[:expire].to_i if options.key?(:expire)

      signer.presigned_url(:get_object, opts)
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
      @s3_uri.path.sub(%r{\A/}, "")
    end
  end
end
