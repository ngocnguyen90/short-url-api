require 'rails_helper'

RSpec.describe Url, type: :model do
  let(:valid_long_url) do
    'https://google.com'
  end

  let(:valid_short_url) do
    'http://short.es/nt48eozb'
  end

  it 'has a valid factory' do
    url = FactoryBot.create(:url, long_url: valid_long_url)
    expect(url).to be_valid
  end

  it 'success: valid long_url when encode, should pass' do
    url = FactoryBot.build(:url, long_url: valid_long_url).save!(context: :encode)
    expect(url).to be_truthy
  end

  it 'success: valid short_url when decode, should pass' do
    url = FactoryBot.build(:url, short_url: valid_short_url).save!(context: :decode)
    expect(url).to be_truthy
  end

  it 'error: invalid long_url when encode, should fail' do
    url = FactoryBot.build(:url, long_url: 'fakestring')
    expect { url.save!(context: :encode) }.to raise_error(ActiveRecord::RecordInvalid)
  end

  it 'error: invalid short_url when decode, should fail' do
    url = FactoryBot.build(:url, short_url: 'fakestring')
    expect { url.save!(context: :decode) }.to raise_error(ActiveRecord::RecordInvalid)
  end

  describe '#generate_short_url' do
    it 'success: valid long_url, should pass' do
      params = {
        'long_url': valid_long_url
      }

      short_url = Url.new(params).generate_short_url
      expect(short_url).to be_truthy
    end
  end

  describe '#generate_short_url' do
    it 'success: valid long_url, should pass' do
      params = {
        'long_url': valid_long_url
      }

      short_url = Url.new(params).generate_short_url
      expect(short_url).to be_truthy
    end
  end

  describe '#find_duplicate' do
    before :each do
      @url = FactoryBot.create(:url, long_url: valid_long_url)
    end

    it 'success: exist long_url, should pass' do
      params = {
        'long_url': valid_long_url
      }

      long_url = Url.new(params).find_duplicate.long_url
      expect(long_url).to eq(valid_long_url)
    end

    it 'error: not exist long_url, should fail' do
      params = {
        'long_url': 'http://facebook.com'
      }

      long_url = Url.new(params).find_duplicate
      expect(long_url).to be_nil
    end
  end

  describe '#find_by_short_url' do
    before :each do
      @url = FactoryBot.create(:url, long_url: valid_long_url)
    end

    it 'success: exist short_url, should pass' do
      params = {
        'short_url': @url.short_url
      }

      short_url = Url.new(params).find_by_short_url.short_url
      expect(short_url).to eq(@url.short_url)
    end

    it 'error: not exist short_url, should fail' do
      params = {
        'short_url': 'aaaabbbb'
      }

      short_url = Url.new(params).find_by_short_url
      expect(short_url).to be_nil
    end
  end

  describe '#new_url?' do
    before :each do
      @url = FactoryBot.create(:url, long_url: valid_long_url)
    end

    it 'success: exist long_url, should false' do
      params = {
        'long_url': valid_long_url
      }

      new_url = Url.new(params).new_url?
      expect(new_url).to be_falsey
    end

    it 'error: not exist long_url, should true' do
      params = {
        'long_url': 'http://facebook.com'
      }

      new_url = Url.new(params).new_url?
      expect(new_url).to be_truthy
    end
  end

  describe '#can_decode?' do
    before :each do
      @url = FactoryBot.create(:url, long_url: valid_long_url)
    end

    it 'should work' do
      params = {
        'short_url': "http://short.es/#{@url.short_url}"
      }

      url = Url.new(params).can_decode?
      expect(url).to be_truthy
    end
  end

  describe '#short_url_sanitize' do
    it 'should work' do
      params = {
        'short_url': 'http://short.es/aaaabbbb'
      }

      url = Url.new(params).short_url_sanitize
      expect(url).to eq('aaaabbbb')
    end
  end

  describe '#encode!' do
    it 'should work' do
      params = {
        'long_url': valid_long_url
      }

      url = Url.new(params).encode!
      expect(url).to be_truthy
    end
  end
end
