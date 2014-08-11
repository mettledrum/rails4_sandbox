class UserMailer < ActionMailer::Base
  default from: "from@example.com"

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.authentication.subject
  #
  def authentication(user)
    @user = user
    @confirmation_fake_url = "localhost:3000" + user_authenticate_path(@user, token: @user.token)

    mail to: "to@example.org"
  end
end
