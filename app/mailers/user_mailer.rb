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
                                          'template_id': '63322334-c229-4cf0-9569-d50fa1dd2418'
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
                    'template_id': '4d608fc9-405f-4cb7-8118-50e60eb6aff8'
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
                    'template_id': '63322334-c229-4cf0-9569-d50fa1dd2418'
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
                    'template_id': '4d608fc9-405f-4cb7-8118-50e60eb6aff8'
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
                    'template_id': '63322334-c229-4cf0-9569-d50fa1dd2418'
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
                    'template_id': '4d608fc9-405f-4cb7-8118-50e60eb6aff8'
                }
            }
        }
    }.to_json

    @alert_limit = alert_tbo

    mail to: emails, subject: 'Notificación'
  end
  def bug_report(report)
    headers['X-SMTPAPI'] = {
        'filters': {
            'templates': {
                'settings': {
                    'enable': 1,
                    'template_id': 'eb50880f-1e81-4c47-b8c1-fa3e3086a803'
                }
            }
        }
    }.to_json

    @report = report

    mail to: 'franzbeltran79@gmail.com', subject: 'BUG reportado'
  end
end
