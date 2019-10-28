json.id          @comment.id
json.content     @comment.content
json.product_id  @comment.product_id
json.user_id     @comment.user_id
json.date        @comment.created_at.strftime("%Y/%m/%d %H:%M")
json.user_name   @comment.user.nickname