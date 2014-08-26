class Comment < ActiveRecord::Base
	belongs_to :posting
	belongs_to :user
  belongs_to :parent, class_name: :Comment

  validates_presence_of :posting
	validates_presence_of :content
	validates_presence_of :user

	validate :cannot_form_a_loop
	validate :cannot_be_parent_of_self
  validate :child_cannot_belong_to_different_posting
  validate :parent_must_exist_if_id_is_given

  has_many   :children,
             -> { order(:created_at) },
             foreign_key: :parent_id,
             class_name:  :Comment,
             dependent:   :destroy	

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
    return if id.nil? || parent_id.nil?
    errors.add(:parent_id, 'cannot be parent of self.') if parent_id == id
  end

  # ensure that a comment cannot be its own ancestor
  def cannot_form_a_loop
    ancestors = self.class.find(parent_id).ancestors rescue []
    errors.add(:parent_id, 'cannot form a loop.') if ancestors.include? self
  end

  def child_cannot_belong_to_different_posting
    if parent && parent.posting_id != self.posting_id
      errors.add(:posting_id, 'must be same as parent.')
    end
  end

  def parent_must_exist_if_id_is_given
    if self.parent_id && !Comment.find_by_id(self.parent_id)
      errors.add(:parent_id, 'comment must exist if referenced.')
    end
  end
end
