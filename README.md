# Open Social

Add social login support to [Open][1] store. Open Social handles authorization, account
creation and association through third-party services. Currently Twitter,
Facebook, Github, Google OAuth2, and Amazon are available out of the box.

---

## Installation

1. Add this extension to your Gemfile with this line:

  ```ruby
  gem 'open_social', github: '99cm/open_social'
  ```
Then run:

  ```ruby
  bundle install
  ```

2. Copy & run migrations
  ```ruby
  bundle exec rails g open_social:install
  bundle exec rake db:migrate
  ```

3. Restart your server

  If your server was running, restart it so that it can find the assets properly.


Preference(optional): By default the login path will be `/users/auth/:provider`. If you wish to modify the path to: `/member/auth/:provider`, `/profile/auth/:provider`, or `/auth/:provider` then you can do this accordingly in your **config/initializers/open_social.rb** file as described below:

```ruby
Spree::SocialConfig[:path_prefix] = 'member'  # for /member/auth/:provider
Spree::SocialConfig[:path_prefix] = 'profile' # for /profile/auth/:provider
Spree::SocialConfig[:path_prefix] = ''        # for /auth/:provider
```

---

## Utilize OAuth Sources

Login as an admin user and navigate to Configuration > Social Authentication Methods

Click on the New Authentication Method button to enter the key obtained from their respective source, (See below for instructions on setting up the various providers).

Multiple key entries can now be entered based on the rails environment. This allows for portability and the lack of need to check in your key to your repository. You also have the ability to enable and disable sources. These setting will be reflected on the client UI as well.

Alternatively you can ship keys as environment variables and create these Authentication Method records on application boot via an initializer. Below is an example for facebook.

```ruby
# Ensure our environment is bootstrapped with a facebook connect app
if ActiveRecord::Base.connection.data_source_exists? 'spree_authentication_methods'
  Spree::AuthenticationMethod.where(environment: Rails.env, provider: 'facebook').first_or_create do |auth_method|
    auth_method.api_key = ENV['FACEBOOK_APP_ID']
    auth_method.api_secret = ENV['FACEBOOK_APP_SECRET']
    auth_method.active = true
  end
end
```

**You MUST restart your application after configuring or updating an authentication method.**

---

## Registering Your Application

Facebook, Twitter, Github, Google OAuth2, and Amazon are supported out of the
box but, you will need to register your application with each of the sites you
want to use.

When setting up development applications, keep in mind that most services do
not support `localhost` for your URL/domain. You will need to us a regular
domain (i.e.  `domain.tld`, `hostname.local`) or an IP addresses (`127.0.0.1`).
Make sure you specifity the right IP address.

### Facebook

[Facebook / Developers / Apps][2]

1. Name the app what you will and agree to the terms.
2. Fill out the capcha
3. Under the Web Site tab
4. Site URL: http://your_computer.local:3000 for development / http://your-site.com for production
5. Site domain: your-computer.local / your-site.com respectively

### Twitter

[Twitter / Application Management / Create an application][3]

1. Name and Description must be filled in with something
2. Application Website: http://your_computer.local:3000 for development / http://your-site.com for production
3. Application Type: Browser
4. Callback URL: http://your_computer.local:3000 for development / http://your-site.com for production
5. Default Access Type: Read & Write
6. Save Application

### Github

[Github / Applications / Register a new OAuth application][4]

1. Name The Application
2. Main URL: http://your_computer.local:3000 for development / http://your-site.com for production
3. Callback URL: http://your_computer.local:3000 for development / http://your-site.com for production
4. Click Create

> This does not seem to be a listed Github item right now. To View and / or edit your applications goto [http://github.com/account/applications](http://github.com/account/applications)

### Amazon

[Amazon / App Console / Register a new OAuth application][10]

1. Register New Application
2. Name the Application, provide description and URL for Privacy Policy
3. Click Save
4. Add Your site under Web Settings > Allowed Return URLs (example: http://localhost:3000/users/auth/amazon/callback)

> The app console is available at [https://login.amazon.com/manageApps](https://login.amazon.com/manageApps)

### Google OAuth2
[Google / APIs / Credentials/ Create Credential][12]

1. In the APIs and Services dashboard, visit 'Credentials' on the side, then select 'Create Credentials' and 'Oauth client ID'.
2. Name the Application, select "Web Application" as a type.
3. Under "Authorized redirect URIs", add your site (example: http://localhost:3000/users/auth/google_oauth2/callback)

> More info: [https://developers.google.com/identity/protocols/OAuth2](https://developers.google.com/identity/protocols/OAuth2)

## Adding other OAuth sources

It is easy to add any OAuth source, given there is an [OmniAuth strategy gem][13] for it (and if not, you can easily [write one by yourself](https://github.com/intridea/omniauth/wiki/Strategy-Contribution-Guide).

#### LinkedIn Example

1, Add `gem "omniauth-linkedin"` to your Gemfile, run `bundle install`.

2. In `config/initializers/open_social.rb` add and initialize a new provider
   for OpenSocial:

   ```ruby

     config.providers = {
       # The configuration key has to match your omniauth strategy.
       linkedin: {
         api_key: ENV['LINKEDIN_API_KEY'],
         api_secret: ENV['LINKEDIN_API_SECRET'],
       },
       # More providers here
   ```
3. Activate your provider as usual.
4. Do **one** of the following:

   - Override the `spree/users/social` view to render OAuth links to display
     your LinkedIn link.
   - Include in your CSS a definition for `.icon-spree-linkedin-circled` and an
     embedded icon font for LinkedIn from [Fontello][14] (the way existing
     icons for Facebook, Twitter, etc are implemented). You can also override
     CSS classes for other providers, `.icon-spree-<provider>-circled`, to use
     different font icons or classic background images, without having to
     override views.
---

## Contributing

See corresponding [guidelines][11].

---

Copyright (c) 2019 [Leo][7] and [contributors][8], released under the [New BSD License][9]

[1]: https://github.com/99cm/open
[2]: https://developers.facebook.com/apps/?action=create
[3]: https://apps.twitter.com/app/new
[4]: https://github.com/settings/applications/new
[5]: http://www.fsf.org/licensing/essays/free-sw.html
[6]: https://github.com/99cm/open_social/issues
[7]: https://github.com/99cm
[8]: https://github.com/99cm/open_social/graphs/contributors
[9]: https://github.com/99cm/open_social/blob/master/LICENSE.md
[10]: https://login.amazon.com/manageApps
[11]: https://github.com/99cm/open_social/blob/master/CONTRIBUTING.md
[12]: https://console.developers.google.com
[13]: https://github.com/intridea/omniauth/wiki/List-of-Strategies
[14]: http://fontello.com/