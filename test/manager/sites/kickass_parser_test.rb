#!/usr/bin/ruby
require_relative '../../test_helper'

require_relative '../../../lib/manager/sites/kickass_parser'
require_relative '../../../lib/manager/mechanize_manager'

# Tests for kickass
class TestKickassClass < Test::Unit::TestCase
  def test_main_divs
    search_term = 'a pigeon sat on a branch reflecting on existence'

    mock_request

    result = MechanizeManager.new.search_kickass(search_term)

    assert_not_nil result
    assert_false result.empty?
  end

  def mock_request
    file_path = 'test_data/kickass_mock_response.html'
    mock_data = File.read(File.join(__dir__, file_path))
    WebMock.stub_request(:get, 'https://kat.cr/usearch/a%20pigeon%20sat%20on%20a%20branch%20reflecting%20on%20existence')
      .to_return(:status => 200, :body => mock_data, :headers => {})
  end
end
