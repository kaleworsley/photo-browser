require File.expand_path('lib/photo_browser/filesystem.rb')

PhotoBrowser::Filesystem::BASE_PATH = File.expand_path('spec/sandbox')

describe PhotoBrowser::Filesystem do
  describe "::years" do
    it { expect(PhotoBrowser::Filesystem.years).to eq ['2013'] }
  end

  describe "::months" do
    it { expect(PhotoBrowser::Filesystem.months('2013')).to eq ['Feb','Jan'] }
    it { expect{PhotoBrowser::Filesystem.months('2012')}.to raise_error(PhotoBrowser::InvalidYearError) }
    it { expect{PhotoBrowser::Filesystem.months('invalid')}.to raise_error(PhotoBrowser::InvalidYearError) }
  end

  describe "::photos" do
    it { expect(PhotoBrowser::Filesystem.photos('2013', 'Jan')).to eq ['photo1.jpg', 'photo2.jpg'] }
    it { expect(PhotoBrowser::Filesystem.photos('2013', 'Feb')).to eq [] }
    it { expect{PhotoBrowser::Filesystem.photos('2012', 'Jan')}.to raise_error(PhotoBrowser::InvalidYearError) }
    it { expect{PhotoBrowser::Filesystem.photos('2013', 'Mar')}.to raise_error(PhotoBrowser::InvalidMonthError) }
    it { expect{PhotoBrowser::Filesystem.photos('2013', 'invalid')}.to raise_error(PhotoBrowser::InvalidMonthError) }
  end

  describe "::photo" do
    it { expect(PhotoBrowser::Filesystem.photo('2013', 'Jan', 'photo1.jpg')).to eq 'photo1.jpg' }
    it { expect{PhotoBrowser::Filesystem.photo('2012', 'Jan', 'photo1.jpg')}.to raise_error(PhotoBrowser::InvalidYearError) }
    it { expect{PhotoBrowser::Filesystem.photo('2013', 'Mar', 'photo1.jpg')}.to raise_error(PhotoBrowser::InvalidMonthError) }
    it { expect{PhotoBrowser::Filesystem.photo('2013', 'Jan', 'photo_fake.jpg')}.to raise_error(PhotoBrowser::InvalidPhotoError) }
    it { expect{PhotoBrowser::Filesystem.photo('2013', 'Feb', 'invalid')}.to raise_error(PhotoBrowser::InvalidPhotoError) }
  end
end
