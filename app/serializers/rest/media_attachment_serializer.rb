# frozen_string_literal: true

class REST::MediaAttachmentSerializer < ActiveModel::Serializer
  include RoutingHelper

  attributes :id, :type, :url, :preview_url,
             :remote_url, :text_url, :meta

  def url
    full_asset_url(object.file.url(:original))
  end

  def preview_url
    url = full_asset_url(object.file.url(:small))
    url.sub! '.mp4', '.png'
  end

  def text_url
    object.local? ? medium_url(object) : nil
  end

  def meta
    object.file.meta
  end
end
