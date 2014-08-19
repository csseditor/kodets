def create_languages
  languages = [["C", "c_cpp", "c"], ["C++", "c_cpp", "c++"], ["C#", "csharp", "csharp"],
              ["HTML", "html", ""], ["JavaScript", "javascript", "javascript"],
              ["Lua", "lua", "lua"], ["Markdown", "markdown"], ["PHP", "php", "php"],
              ["Python 2", "python", "python2"], ["Python 3", "python", "python3"],
              ["Ruby", "ruby", "ruby"]]

  unless Language.all.count == languages.length
    languages.each do |language|
      Language.create name: language[0], ace_slug: language[1], code_eval_slug: language[2]
    end
  end
end

def create_organisation
  Organisation.create(name: 'Horsforth School',
                      email: 'teacher@horsforthscool.org',
                      max_users: 50,
                      url: 'http://horsforthschool.org')
end

def create_students
  User.create(name: 'Student 1',
              email: 'greentp02@horsforthschool.org',
              username: 'greentp02@horsforthschool.org',
              password: 'password',
              password_confirmation: 'password',
              organisation_id: Organisation.first.id)
end

def create_teacher
  User.create(name: 'Teacher 1',
              email: 'teacher@horsforthschool.org',
              username: 'teacher@horsforthschool.org',
              password: 'password',
              password_confirmation: 'password',
              organisation_id: Organisation.first.id,
              teacher: true)
end

def create_course
  Course.create(name: 'Ruby Test Course', 
                description: 'Ruby is a scripting language',
                organisation_id: Organisation.first.id)
end

def create_track
  Track.create(name: 'Ruby Test Track',
               description: 'Introduction to Ruby',
               course_id: Course.first.id)
end

create_languages
create_organisation
create_students
create_teacher
create_course
create_track