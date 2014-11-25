require 'rails_helper'

describe 'playlist management' do

  def sign_up_as_panda
    visit '/'
    click_link 'Sign up'
    fill_in 'Email', with: 'panda@test.com'
    fill_in 'Username', with: 'Panda123'
    fill_in 'First name', with: 'Panda'
    fill_in 'Last name', with: 'Pop'
    fill_in 'Password', with: 'pandapop123'
    fill_in 'Password confirmation', with: 'pandapop123'
    click_button 'Sign up'
  end
  
  context 'User is not logged in' do
    it 'should not see a link to create a playlist' do
      visit '/'
      expect(page).not_to have_content "New playlist"
    end
  end

  context 'User is logged in' do

    before do
      @panda = User.create(email: 'panda123@test.com', username: 'panda123', first_name: 'panda', last_name: 'pop', password: 'pandapop123', password_confirmation: 'pandapop123')
      login_as @panda
    end

    it 'user can see a link to create a playlist' do
      visit '/'
      expect(page).to have_link 'Create playlist'
    end

    it 'should be able to create a playlist with a name' do
      visit '/'
      click_link 'Create playlist'
      expect(current_path).to eq new_user_playlist_path(@panda)
      fill_in "Name", with: "Taylor Swift Jamz"
      click_button "Create playlist"
      expect(page).to have_link "Taylor Swift Jamz"
    end

    context 'playlist viewing, editing, deleting' do 

      before do 
        @shakeitoff = Track.create(title: 'Shake it off', youtube_url: "www.youtube.com/taylor", duration: "4.00", plays: "4")
        @taylorjamz = Playlist.create(user: @panda, name: "Taylor Swift Jamz")
      end

      it 'a user can view tracks added to a playlist' do 
        visit '/'
        expect(page).to have_content 'Taylor Swift Jamz'
        click_link 'Taylor Swift Jamz'
        expect(current_path).to eq user_playlist_path(@panda, @taylorjamz)
      end

      # it 'a user can add a track to a playlist from the track page' do 
      #   visit '/'
      #   click_link 'Shake it off'
      #   # select('Taylor Swift Jamz', from: 'addtoplaylist')
      #   # find('#addtoplaylist').find(:xpath, 'Taylor Swift Jamz').select
      #   fill_in 'Playlist', with: @taylorjamz
      #   click_button "Update Track"
      #   expect(page).to have_content "Track added to playlist"
      # end

    end

  end
end