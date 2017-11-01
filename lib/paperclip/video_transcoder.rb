# frozen_string_literal: true

module Paperclip
  # This transcoder is only to be used for the MediaAttachment model
  # to check when uploaded videos are actually gifv's
  class VideoTranscoder < Paperclip::Processor
    def make
      meta = ::Av.cli.identify(@file.path)
      attachment.instance.type = MediaAttachment.types[:gifv] unless meta[:audio_encode]

      if options[:style] == :small
        attachment.instance.file_file_name    = 'preview.gif'
        attachment.instance.file_content_type = 'image/gif'
      end

      Paperclip::Transcoder.make(file, options, attachment)
    end
  end
end
