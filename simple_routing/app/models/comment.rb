class Comment < ActiveRecord::Base
	belongs_to :posting
	belongs_to :user
  belongs_to :parent, class_name: :Comment

	validates_presence_of :posting
	validates_presence_of :user
	validate :cannot_form_a_loop
	validate :cannot_be_parent_of_self

  has_many   :children,
             foreign_key: :parent_id,
             class_name:  :Comment,
             dependent:   :restrict_with_exception	

	include Votable

  # get the chain of ancestors for this comment
  def ancestors
    parent ? parent.ancestors << parent : []
  end

  # build a tree from this comment, including all children recursively
  def tree
    {
      comment: self,
      children: children.map(&:tree),
    }
  end

	# ensure that a comment cannot be its own parent
  def cannot_be_parent_of_self
    if id.nil? || parent_id.nil?
    	errors.add(:parent_id, 'Comment cannot be parent of self.') if parent_id == id
    	return
  	end
  end

  # ensure that a comment cannot be its own ancestor
  def cannot_form_a_loop
    ancestors = self.class.find(parent_id).ancestors rescue []
    errors.add(:parent_id, 'Comment cannot form a loop in tree.') if ancestors.include? self
  end
end
