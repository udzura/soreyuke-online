# -*- coding: utf-8 -*-
require 'bundler'
#require 'sinatra'
Bundler.require

# require "sinatra/reloader" if development?

helpers do
  # This is a Ruby 2 feature
  def presence_of(word: nil)
    word.nil? || word.size <= 0 ? nil : word
  end
end

get '/' do
  slim :index
end

get '/say-hello' do
  word = presence_of(word: params[:word])
  @text = Pebbles::Soreyuke::AA(params[:type], word)
  slim :hello
end


__END__

@@ layout
doctype html
html
  head
    title 便利ウェブアプリサンプル
    link href="/css/bootstrap.min.css" rel="stylesheet"
    css:
      body { padding-top: 60px; }

  body
    .navbar.navbar-inverse.navbar-fixed-top
      .navbar-inner
        .container
          a.brand href="/" The Sinatra 1.4 & Ruby 2.0 Example
    .container
      == yield
      .well.well-small
        p © Uchio KONDO 2013.
        p
          | Using
          code= RUBY_DESCRIPTION
          |  & Sinatra
          code= Sinatra::VERSION

    script src="http://code.jquery.com/jquery.js"
    script src="/js/bootstrap.min.js"


@@ index
.row
  .hero-unit
    h1 Hello
    p コレがルビー2.0 & シナトリャ 1.4 だァーッ
  .span9
    h2 インタラクティブコンテンツを試す
    form action='/say-hello' method='GET'
      fieldset
        label タイプ :
        select name="type"
          option value="apm" あんパン
          option value="cpm" カレーパン
          option value="spm" 食パン
        label 挨拶の文言 :
        input type='text' name='word'
        br
        input.btn type="submit" value="シナトラを試す"

@@ hello
.row
  .span9
    pre
      = @text
  .span9
    p
      a.btn href="/" Back
