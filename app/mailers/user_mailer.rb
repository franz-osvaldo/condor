class UserMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.notification.subject
  #

  def fluid_warning(emails, alert_fluid)
    headers['X-SMTPAPI'] = {
                              'filters': {
                                  'templates': {
                                      'settings': {
                                          'enable': 1,
                                          'template_id': '1b361325-f39a-4389-b459-82532a9b2ce7'
                                      }
                                  }
                              }
                           }.to_json

    @alert_fluid = alert_fluid

    mail to: emails, subject: 'Notificación'
  end
  def fluid_accomplished(emails, alert_fluid)
    headers['X-SMTPAPI'] = {
        'filters': {
            'templates': {
                'settings': {
                    'enable': 1,
                    'template_id': '2e643f36-85ba-4b93-82c3-1eebde299799'
                }
            }
        }
    }.to_json

    @alert_fluid = alert_fluid

    mail to: emails, subject: 'Notificación'
  end
  def tbo_warning(emails, alert_tbo)
    headers['X-SMTPAPI'] = {
        'filters': {
            'templates': {
                'settings': {
                    'enable': 1,
                    'template_id': '1b361325-f39a-4389-b459-82532a9b2ce7'
                }
            }
        }
    }.to_json

    @alert_tbo = alert_tbo

    mail to: emails, subject: 'Notificación'
  end
  def tbo_accomplished(emails, alert_tbo)
    headers['X-SMTPAPI'] = {
        'filters': {
            'templates': {
                'settings': {
                    'enable': 1,
                    'template_id': '2e643f36-85ba-4b93-82c3-1eebde299799'
                }
            }
        }
    }.to_json

    @alert_tbo = alert_tbo

    mail to: emails, subject: 'Notificación'
  end

  def limit_warning(emails, alert_tbo)
    headers['X-SMTPAPI'] = {
        'filters': {
            'templates': {
                'settings': {
                    'enable': 1,
                    'template_id': '1b361325-f39a-4389-b459-82532a9b2ce7'
                }
            }
        }
    }.to_json

    @alert_limit = alert_tbo

    mail to: emails, subject: 'Notificación'
  end
  def limit_accomplished(emails, alert_tbo)
    headers['X-SMTPAPI'] = {
        'filters': {
            'templates': {
                'settings': {
                    'enable': 1,
                    'template_id': '2e643f36-85ba-4b93-82c3-1eebde299799'
                }
            }
        }
    }.to_json

    @alert_limit = alert_tbo

    mail to: emails, subject: 'Notificación'
  end
end
