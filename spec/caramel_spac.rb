# coding: utf-8

require File.dirname(__FILE__) + '/spec_helper'

module Caramel
  shared_examples 'ObjectModifierWrapper' do |klass|
    before do
      @mock = mock(:parent)
      @method_name = :cat
      @object = klass.new(@mock)
    end
    context "don't set alter" do
      before do
        @expected = 'cat is so cute'
        @mock.should_receive(@method_name).and_return(@expected)
      end
      subject { @object }
      it 'returns expected word' do
        result = subject.__send__(@method_name)
        result.should == @expected
      end
    end
    context "set alter" do
      before do
        @head = 'He said: '
        @word = 'this is a pen.'
        @expected = @head + @word
        @mock.should_receive(@method_name).and_return(@word)
        @object.instance_eval do
          def alter
            'He said: ' + @result
          end
        end
      end
      subject { @object }
      it 'returns expected word' do
        result = subject.__send__(@method_name)
        result.should == @expected
      end
    end
  end

  describe ObjectModifierWrapper, :shared => true do
    include_examples 'ObjectModifierWrapper', ObjectModifierWrapper
  end

  describe NilModifierWrapper do
    before do
      @mock = mock(:parent)
    end
    context 'parent is nil' do
      before do
        @object = NilModifierWrapper.new(nil)
      end
      subject { @object }
      it 'returns nil always' do
        subject.hoge.should be_nil
      end
    end
    context 'parent is mock' do
      before do
        @method_name = :hoge
        @expected = 'cute cat'
        @mock.should_receive(@method_name).and_return(@expected)
        @object = NilModifierWrapper.new(@mock)
      end
      subject { @object }
      it "returns parent's result" do
        subject.__send__(@method_name).should == @expected
      end
    end
  end

  describe IsWrapper do
    include_examples 'ObjectModifierWrapper', IsWrapper
  end

  describe NotWrapper do
    before do
      @method_name = :piyo
      @mock = mock(:parend)
    end
    context 'when mock returns true' do
      before do
        @mock.stub!(@method_name => true)
        @object = NotWrapper.new(@mock)
      end
      subject { @object }
      it 'returns false' do
        subject.__send__(@method_name).should be_false
      end
    end
    context 'when mock returns false' do
      before do
        @mock.stub!(@method_name => false)
        @object = NotWrapper.new(@mock)
      end
      subject { @object }
      it 'returns false' do
        subject.__send__(@method_name).should be_true
      end
    end
  end

  describe Object do
    describe '#is' do
      before do
        @name = 'John'
        @person = @name
      end
      context 'when give argument' do
        subject { @person }
        it 'returns true' do
          subject.is(@name).should be_true
        end
      end
      context "when doesn't give argument" do
        subject { @person }
        it 'calls IsWrapper.new with self' do
          IsWrapper.should_receive(:new).with(subject)
          subject.is
        end
      end
    end

    describe '#not' do
      before do
        @name = 'John'
        @other_name = 'Jack'
        @person = @name
      end
      context 'when give argument' do
        subject { @person }
        it 'returns true' do
          subject.not(@other_name).should be_true
        end
      end
      context "when doesn't give argument" do
        subject { @person }
        it 'calls NotWrapper.new with self' do
          NotWrapper.should_receive(:new).with(subject)
          subject.not
        end
      end
    end

    describe '#and' do
      before do
        @name = 'John'
        @person = @name
      end
      context 'when give argument' do
        subject { @person }
        it 'returns true' do
          subject.and(@name).should be_true
        end
      end
      context "when doesn't give argument" do
        subject { @person }
        it 'calls NilModifierWrapper.new with self' do
          NilModifierWrapper.should_receive(:new).with(subject)
          subject.and
        end
      end
    end

    describe '#in?' do
      before do
        @array = [1, 2, 3, 4, 5]
      end
      context 'when included' do
        before do
          @target = 2
        end
        subject { @target }
        it 'returns true' do
          should be_in(@array)
        end
      end
      context "when doen't included" do
        before do
          @target = 7
        end
        subject { @target }
        it 'returns false' do
          should_not be_in(@array)
        end
      end
    end
  end
end

