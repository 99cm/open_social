RSpec.feature 'Admin Authentication Methods', :js do
  stub_authorization!

  context 'elements' do
    scenario 'has configuration tab' do
      visit spree.admin_path
      click_link 'Settings'
      expect(page).to have_text(/Social Authentication Methods/i)
    end
  end

  context 'when no auth methods exists' do
    background do
      visit spree.admin_authentication_methods_path
    end

    scenario 'can create new' do
      expect(page).to have_text 'No Authentication Methods Found, Add One!'

      click_link 'New Authentication Method'
      expect(page).to have_text 'Back To Authentication Methods List'

      select 'Test', from: 'authentication_method[environment]'
      select2 'Github', from: 'Social Provider'

      click_button 'Create'
      expect(page).to have_text 'successfully created!'
    end
  end

  context 'when auth method exists' do
    given!(:authentication_method) do
      Spree::AuthenticationMethod.create!(
        provider: 'facebook',
        api_key: 'fake',
        api_secret: 'fake',
        environment: Rails.env,
        active: true)
    end

    background do
      visit spree.admin_authentication_methods_path
    end

    scenario 'can be updated' do
      within_row(1) do
        click_icon :edit
      end

      find('#authentication_method_active_false').click

      click_button 'Update'
      expect(page).to have_text 'successfully updated!'
    end

    scenario 'can be deleted' do
      accept_alert do
        within_row(1) do
          click_icon :trash
        end
      end

      expect(page).to have_text 'successfully removed!'
      expect(page).not_to have_text authentication_method.provider
    end
  end
end