#! /usr/bin/env ruby
require 'minitest/autorun'
require 'tempfile'

class TempfileTest < Minitest::Test
  def setup
    @name = 'canary'
    @content = 'hello world'
    @generated_path = nil
  end

  def teardown
    if File.exists?(@generated_path)
      puts "cleaning up #{@generated_path}.."
      File.unlink(@generated_path)
    end
  end

  def get_tempfile
    file = Tempfile.new(@name)
    @generated_path = file.path
    assert_match /#{@name}/, @generated_path
    file.write(@content)
    file.rewind
    assert_equal @content, file.read
    file.close
    assert_file_exists
    file
  end

  def assert_file_exists
    assert File.exists?(@generated_path), "#{@generated_path} should exist"
  end

  def assert_file_not_present
    assert !File.exists?(@generated_path), "#{@generated_path} should not exist"
  end

  def test_allows_explicit_removal
    file = get_tempfile
    file.unlink
    assert_file_not_present
  end

  def test_immediate_removal_with_close!
    file = get_tempfile
    file.close!
    assert_file_not_present
  end

  def test_garbage_collection_causes_implicit_removal
    get_tempfile
    GC.start
    assert_file_not_present
  end

  def test_undefine_finalizer_disables_implicit_removal
    file = get_tempfile
    ObjectSpace.undefine_finalizer(file)
    GC.start
    assert_file_exists
    File.unlink(file.path)
    assert_file_not_present
  end

  def test_block_usage
    Tempfile.open(@name) do |file|
      @generated_path = file.path
      assert_match /#{@name}/, @generated_path
      file.write(@content)
      file.rewind
      assert_equal @content, file.read
    end
    assert_file_exists
    GC.start
    assert_file_not_present
  end
end
