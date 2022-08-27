enum view_displayed: Int32 {
    case drill = 0
    case quiz = 1
    case auto = 2
}


enum QuizType: Int32 {
        case timedSetVerbs = 0
        case timedNoSet = 1
        case untimed = 2
        init() {
            var val = UDefs.int32(forKey: K.quizType, withDefault:0)
            if val > 1 {
                val = 0
            }
            self = QuizType(rawValue: val )!
        }
        func save() {
            UDefs.set(value: self.rawValue, forKey: K.quizType)
        }
        
        func print() {
            Log.print("quizType_enum: \(self)")
        }
        
        mutating func retrieve() {
            var val = UDefs.int32(forKey: K.quizType, withDefault: 0)
            if val > 1 {
                val = 0
            }
            self = QuizType(rawValue: val )!
        }

    }
    
    enum tense_location: Int {
        case default_locale = 0
        case alternative_locale_1 = 1
        
        init() {
            var val = UDefs.int(forKey: K.keyTenseLocale, withDefault:0)
            if val > 1 {
                val = 0
            }
            self = tense_location(rawValue: val )!
        }
        func save() {
            UDefs.set(value: self.rawValue, forKey: K.keyTenseLocale)
        }
        
        func print() {
            Log.print("quizType_enum: \(self)")
        }
        
        mutating func retrieve() {
            var val = UDefs.int(forKey: K.keyTenseLocale, withDefault: 0)
            if val > 1 {
                val = 0
            }
            self = tense_location(rawValue: val )!
        }
    }
    
    enum ColorScheme: Int32 {
        case dark_on_light = 0
        case light_on_dark = 1
        init() {
            var val = UDefs.int32(forKey: K.keyColorScheme, withDefault:0)
            if val > 1 {
                val = 0
            }
            self = ColorScheme(rawValue: val )!
        }
        func save() {
            UDefs.set(value: self.rawValue, forKey: K.keyColorScheme)
        }
        
        func print() {
            Log.print("quizType_enum: \(self)")
        }
        
        mutating func retrieve() {
            var val = UDefs.int32(forKey: K.keyColorScheme, withDefault: 0)
            if val > 1 {
                val = 0
            }
            self = ColorScheme(rawValue: val )!
        }
        
    }
    
    
    enum Popover_enum: Int32 {
        case quizSettings = 0
        case testSettings = 1
        case verbSelectionMode = 2
    }
    
    enum reachable_enum: Int32 {
        case wifi = 0
        case cellular = 1
        case not_reachable = 2

        init() {
            var val = UDefs.int32(forKey: K.keyReachable, withDefault:2)
            if val > 2 {
                val = 2
            }
            self = reachable_enum(rawValue: val )!
        }
        func save() {
            UDefs.set(value: self.rawValue, forKey: K.keyReachable)
        }
        
        func print() {
            Log.print("quizType_enum: \(self)")
        }
        
        mutating func retrieve() {
            var val = UDefs.int32(forKey: K.keyReachable, withDefault: 2)
            if val > 2 {
                val = 2
            }
            self = reachable_enum(rawValue: val )!
        }

    }
    
    enum FileSync: Int32 {
        case local_newer = 0
        case cloud_newer = 1
        case not_in_cloud = 2
        case not_in_local = 3
        case same_date = 4
    }


    
    enum Translation_when: Int32 {
        case atQuiz = 0
        case atAnswer = 1
        case never = 2
        init() {
            var val = UDefs.int32(forKey: K.keyTranslationWhen, withDefault: 0)
            if val > 2 {
                val = 0
            }
            self = Translation_when(rawValue: val)!
        }
        
        func save() {
            UDefs.set(value: self.rawValue, forKey: K.keyTranslationWhen)
        }
        
        func print() {
            Log.print("translation_when: \(self)")
        }
        
        mutating func retrieve() {
            var val = UDefs.int32(forKey: K.keyTranslationWhen, withDefault: 0)
            if val > 2 {
                val = 0
            }
            self = Translation_when(rawValue: val)!
        }
    }
    
    /**
     Determines what will appear in the translation label of a drill- or quiz-view
     the language infinitive
     the english infinitive
    */
    enum Translation_what: Int32 {
        case infinitive = 0
        case verbform = 1
        init() {
            var val = UDefs.int32(forKey: K.keyTranslationWhat, withDefault: 0)
            if val > 1 {
                val = 0
            }
            self = Translation_what(rawValue: val)!
        }
        
        func save() {
            UDefs.set(value: self.rawValue, forKey: K.keyTranslationWhat)
        }
        
        func print() {
            Log.print("translation_what: \(self)")
        }
        
        mutating func retrieve() {
            let val = UDefs.int32(forKey: K.keyTranslationWhat, withDefault: 0)
            self = Translation_what(rawValue: val)!
        }
    }

    /**
    Modes of displaying the list of infinitives. Can display infinitives lists in English or the language
    */
    enum Infinitive_list_display: Int32 {
        case language = 0
        case english = 1
        init() {
            var val = UDefs.int32(forKey: K.keyInfinitiveDisplay, withDefault: 0)
            if val > 1 {
                val = 0
            }
            self = Infinitive_list_display(rawValue: val)!
//            self = Infinitive_mode(rawValue: 0)!
        }
        
        func save() {
            UDefs.set(value: self.rawValue, forKey: K.keyInfinitiveDisplay)
        }
        
        func print() {
            Log.print("Mode: \(self)")
        }
        
        mutating func retrieve() {
            self = Infinitive_list_display(rawValue: UDefs.int32(forKey: K.keyInfinitiveDisplay, withDefault: 0))!
        }
    }
    
    
    enum Quiz_selection_mode: Int32 {
        case use_all_verbs = 0
        case use_verb_list = 1
        case use_one_verb = 2
        
        init() {
            //TODO: need to handle the situation where there is no value in the cloud
            var val = UDefs.int32(forKey: K.keyQuizSelectionMode, withDefault: 0)
            if val > 2 {
                val = 0
            }
            self = Quiz_selection_mode(rawValue: val )!
        }
        
        func save() {
            UDefs.set(value: self.rawValue, forKey: K.keyQuizSelectionMode)
        }
        
        func print() {
            Log.print("Mode: \(self)")
        }
        
        mutating func retrieve() {
            var val = UDefs.int32(forKey: K.keyQuizSelectionMode, withDefault: 0)
            if val > 2 {
                val = 0
            }
            self = Quiz_selection_mode(rawValue: val )!
        }

    }
    
    enum App_language: Int32 {
        case spanish = 0
        case french = 1
        case italian = 2
        case german = 3
        init() {
            //TODO: need to handle the situation where there is no value in the cloud
            var raw: Int32 = 0
            #if _VERBOS_
                raw = 0
            #endif
            #if _VERBES_
                raw = 1
            #endif
            #if _VERBI_
                raw = 2
            #endif
            #if _VERBEN_
                raw = 3
            #endif
            self = App_language(rawValue: raw)!
        }
        
        func save() {
            UDefs.set(value: self.rawValue, forKey: LanguageGlobals.language)
        }
        
        func print() {
            Log.print("Mode: \(self)")
        }
        
        mutating func retrieve() {
            self = App_language(rawValue: UDefs.int32(forKey: LanguageGlobals.language)!)!
        }
       
    }
    /**
     Will show what infinitive to use in infinitive lists
     */
    enum Infinitive_list_toggle: Int32 {
        case language = 0
        case english = 1
        init() {
            var val = UDefs.int32(forKey: K.keyInfinitiveListToggle, withDefault: 0)
            if val > 1 {
                val = 0
            }
            self = Infinitive_list_toggle(rawValue: val)!
        }
        func save() {
            UDefs.set(value: self.rawValue, forKey: K.keyInfinitiveListToggle)
        }
        
        func print() {
            Log.print("infinitive_toggle: \(self)")
        }
        
        mutating func retrieve() {
            var val = UDefs.int32(forKey: K.keyInfinitiveListToggle, withDefault: 0)
            if val > 1 {
                val = 0
            }
            self = Infinitive_list_toggle(rawValue: val)!
        }
    }

    
    /**
     What will show as the infinitive in drill or test-view
     language infinitive
     english infinitive
     english verbform
     */

    enum Infinitive_display: Int32 {
        case show_language_infinitive = 0
        case show_english_infinitive = 1
        case show_verbform_translation = 2
        init() {
            //TODO: need to handle the situation where there is no value in the cloud
            var val = UDefs.int32(forKey: K.keyInfinitiveDisplay, withDefault: 0)
            if val > 2 {
                val = 0
            }
            self = Infinitive_display(rawValue: val)!
        }
        
       func save() {
            UDefs.set(value: self.rawValue, forKey: K.keyInfinitiveDisplay)
        }
        
        func print() {
            Log.print("Mode: \(self)")
        }
        
        mutating func retrieve() {
            var val = UDefs.int32(forKey: K.keyInfinitiveDisplay, withDefault: 0)
            if val > 2 {
                val = 0
            }
            self = Infinitive_display(rawValue: val)!
        }
        
    }
    
    enum Pronoun_display: Int32 {
        case hide_pronoun = 0
        case show_pronoun = 1
        init() {
            //TODO: need to handle the situation where there is no value in the cloud
            var val = UDefs.int32(forKey: K.keyPronounDisplay , withDefault: 0)
            if val > 1 {
                val = 0
            }
            self = Pronoun_display(rawValue: val)!
        }
        
        func save() {
            UDefs.set(value: self.rawValue, forKey: K.keyPronounDisplay)
        }
        
        func print() {
            Log.print("Mode: \(self)")
        }
        
        mutating func retrieve() {
            var val = UDefs.int32(forKey: K.keyPronounDisplay, withDefault: 0)
            if val > 2 {
                val = 0
            }
            self = Pronoun_display(rawValue: val)!
        }
        
    }

    
    // test mode enums
    enum quiz_ending {
        case timed_out
        case answered_out
        case maxed_out
        case canceled_out
    }
    
    enum quiz_type {
        case timed_set
        case timed_no_set
        case untimed
    }
    
    enum web_views: Int {
        case sample_conjugation = 0
        case help_view = 1
        case info_view = 2
        case changes_view = 4
    }
    

