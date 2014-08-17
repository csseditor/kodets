def create_languages
  languages = [["C", "c_cpp", "c"], ["C++", "c_cpp", "c++"], ["C#", "csharp", "csharp"],
              ["HTML", "html", ""], ["JavaScript", "javascript", "javascript"],
              ["Lua", "lua", "lua"], ["Markdown", "markdown"], ["PHP", "php", "php"],
              ["Python 2", "python", "python2"], ["Python 3", "python", "python3"],
              ["Ruby", "ruby", "ruby"]]

  languages.each do |language|
    Language.create(name: language[0], ace_slug: language[1], code_eval_slug: language[2])
  end
end

create_languages
