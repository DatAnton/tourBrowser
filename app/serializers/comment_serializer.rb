class CommentSerializer < ActiveModel::Serializer
  attributes :id, :body, :author
  def author
    {
      user: self.object.user
    }
  end
end
