# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).

# item_types
[:comment, :posting].each do |name|
	ItemType.create(name: name)
end


# sample values for testing

# users
admin = User.create(name: 'Administrator', password: 'ad', email: 'ad', admin: true)
andy = User.create(name: 'Andy', password: 'a', email: 'a')
barry = User.create(name: 'Barry', password: 'b', email: 'b')
chrissy = User.create(name: 'Chrissy', password: 'c', email: 'c')

# postings
apost1 = Posting.create(content: Faker::Lorem.paragraph, user_id: andy.id, title: Faker::Lorem.sentence)
apost2 = Posting.create(content: Faker::Lorem.paragraph, user_id: andy.id, title: Faker::Lorem.sentence)
apost3 = Posting.create(content: Faker::Lorem.paragraph, user_id: andy.id, title: Faker::Lorem.sentence)

bpost1 = Posting.create(content: Faker::Lorem.paragraph, user_id: barry.id, title: Faker::Lorem.sentence)
bpost2 = Posting.create(content: Faker::Lorem.paragraph, user_id: barry.id, title: Faker::Lorem.sentence)
bpost3 = Posting.create(content: Faker::Lorem.paragraph, user_id: barry.id, title: Faker::Lorem.sentence)

cpost1 = Posting.create(content: Faker::Lorem.paragraph, user_id: chrissy.id, title: Faker::Lorem.sentence)
cpost2 = Posting.create(content: Faker::Lorem.paragraph, user_id: chrissy.id, title: Faker::Lorem.sentence)

# root comments
acom_bpost1 = Comment.create(content: Faker::Lorem.sentence, posting_id: bpost1.id, user_id: andy.id, parent_id: nil)
acom_bpost2 = Comment.create(content: Faker::Lorem.sentence, posting_id: bpost2.id, user_id: andy.id, parent_id: nil)
ccom_bpost2 = Comment.create(content: Faker::Lorem.sentence, posting_id: bpost2.id, user_id: chrissy.id, parent_id: nil)
acom_cpost1 = Comment.create(content: Faker::Lorem.sentence, posting_id: cpost1.id, user_id: andy.id, parent_id: nil)
bcom_bpost1 = Comment.create(content: Faker::Lorem.sentence, posting_id: bpost1.id, user_id: barry.id, parent_id: nil)
bcom_bpost12 = Comment.create(content: Faker::Lorem.sentence, posting_id: bpost1.id, user_id: barry.id, parent_id: nil)

# level 1 comments comment (parent is root)
bcom_acom_bpost1 = Comment.create(content: Faker::Lorem.sentence, posting_id: bpost1.id, user_id: barry.id, parent_id: acom_bpost1.id)
bcom_ccom_bpost2 = Comment.create(content: Faker::Lorem.sentence, posting_id: bpost2.id, user_id: barry.id, parent_id: ccom_bpost2.id)
acom_acom_cpost1 = Comment.create(content: Faker::Lorem.sentence, posting_id: cpost1.id, user_id: andy.id, parent_id: acom_cpost1.id)
ccom_bcom_bpost1 = Comment.create(content: Faker::Lorem.sentence, posting_id: bpost1.id, user_id: chrissy.id, parent_id: bcom_bpost1.id)

# level 2 comments comment
acom_bcom_ccom_bpost2 = Comment.create(content: Faker::Lorem.sentence, posting_id: bpost2.id, user_id: andy.id, parent_id: bcom_ccom_bpost2.id)
bcom_acom_acom_cpost1 = Comment.create(content: Faker::Lorem.sentence, posting_id: cpost1.id, user_id: barry.id, parent_id: acom_acom_cpost1.id)
acom_ccom_bcom_bpost1 = Comment.create(content: Faker::Lorem.sentence, posting_id: bpost1.id, user_id: andy.id, parent_id: ccom_bcom_bpost1.id)


# level 3 comments comment
bcom_bcom_acom_acom_cpost1 = Comment.create(content: Faker::Lorem.sentence, posting_id: cpost1.id, user_id: barry.id, parent_id: bcom_acom_acom_cpost1.id)
bcom_acom_bcom_ccom_bpost2 = Comment.create(content: Faker::Lorem.sentence, posting_id: bpost2.id, user_id: barry.id, parent_id: acom_bcom_ccom_bpost2.id)

# TODO: votes