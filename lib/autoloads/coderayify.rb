class Coderayify < Redcarpet::Render::HTML
  def block_code(code, language)
    # コードブロックの拡張子を取得
    ext = retrieve_extension(language)
    # 適用するシンタックスハイライトの言語を決める
    lang = case ext
           when "rb"
             :ruby
           when "yml"
             :yaml
           else
             ext.to_sym
           end
    CodeRay.scan(code, lang).div
  end

  private

  # 拡張子を取得するメソッド
  def retrieve_extension(language)
    if language.blank?
      # コードブロックの開始宣言で「```」の後に拡張子が与えられていない場合は md 形式とみなす
      "md"
    elsif language.include?(":")
      # コードブロックの開始宣言が「```rb:sample.rb」の場合は rb 形式とみなす
      language.split(':')[0]
    elsif language.include?(".")
      # コードブロックの開始宣言が「```sample.rb」の場合は rb 形式とみなす
      language.split('.')[-1]
    else
      language
    end
  end
end