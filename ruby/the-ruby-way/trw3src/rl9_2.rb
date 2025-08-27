class Tree
  # Assumes definitions from
  # previous example...

  def insert(x)
    if @data == nil
      @data = x
    elsif x <= @data
      if @left == nil
        @left = Tree.new x
      else
        @left.insert x
      end 
    else
      if @right == nil
        @right = Tree.new x
      else
        @right.insert x
      end 
    end
  end

  def inorder()
    @left.inorder {|y| yield y} if @left != nil
    yield @data
    @right.inorder {|y| yield y} if @right != nil
  end

  def preorder()
    yield @data
    @left.preorder {|y| yield y} if @left != nil
    @right.preorder {|y| yield y} if @right != nil
  end

  def postorder()
    @left.postorder {|y| yield y} if @left != nil
    @right.postorder {|y| yield y} if @right != nil
    yield @data
  end 
end

items = [50, 20, 80, 10, 30, 70, 90, 5, 14,
         28, 41, 66, 75, 88, 96]
tree = Tree.new
items.each {|x| tree.insert(x)}
￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼
￼￼
￼￼09_9780321714633_ch09.qxd  11/14/14  3:12 PM  Page 302
￼￼
￼￼￼￼
302 9. More Advanced Data Structures
tree.inorder {|x| print x, " "}
puts
tree.preorder {|x| print x, " "}
puts
tree.postorder {|x| print x, " "}
puts

# Output:
# 5 10 14 20 28 30 41 50 66 70 75 80 88 90 96
# 50 20 10 5 14 30 28 41 80 70 66 75 90 88 96
# 5 14 10 28 41 30 20 66 75 70 88 96 90 80 50

