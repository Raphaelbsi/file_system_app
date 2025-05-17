require "active_storage/service/s3_service"

class ActiveStorage::Service::CloudflareS3Service < ActiveStorage::Service::S3Service
  def upload(key, io, checksum: nil, **options)
    opts = options.dup

    opts[:content_disposition] = opts.delete(:disposition)     if opts[:disposition]
    opts[:metadata]            = opts.delete(:custom_metadata) if opts[:custom_metadata]
    opts.delete(:filename)

    instrument :upload, key: key do
      object_for(key).put(body: io, **opts)
    end
  end
end
