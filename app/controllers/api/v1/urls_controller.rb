module Api::V1
  class UrlsController < ApiController
    # POST /urls
    def encode
      @url = Url.new(url_encode_params)
      if @url.new_url?
        if @url.encode!
          render json: @url, status: 200, type: 'encode', location: @url
        else
          render json: @url.errors, status: 400
        end
      else
        render json: @url.find_duplicate, status: 200, type: 'encode', location: @url
      end
    end

    def decode
      @url = Url.new(url_decode_params)
      if @url.valid?(:decode)
        if @url.can_decode?
          render json: @url.find_by_short_url, status: 200, type: 'decode', location: @url
        else
          render json: @url.errors, status: 400
        end
      else
        render json: @url.errors, status: 400
      end
    end

    private

    # Only allow a list of trusted parameters through.
    def url_encode_params
      params.require(:url).permit(:long_url)
    end

    def url_decode_params
      params.require(:url).permit(:short_url)
    end
  end
end
