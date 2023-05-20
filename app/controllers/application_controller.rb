class ApplicationController < ActionController::API
    include ActionController::MimeResponds

    def topic_scope title
        Post.where('content LIKE ?', "%#{title}%")
      end
end
