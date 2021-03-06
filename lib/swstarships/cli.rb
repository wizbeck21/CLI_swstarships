class Cli
    def start
        puts "
        ░██████╗████████╗░█████╗░██████╗░  ░██╗░░░░░░░██╗░█████╗░██████╗░░██████╗  
        ██╔════╝╚══██╔══╝██╔══██╗██╔══██╗  ░██║░░██╗░░██║██╔══██╗██╔══██╗██╔════╝  
        ╚█████╗░░░░██║░░░███████║██████╔╝  ░╚██╗████╗██╔╝███████║██████╔╝╚█████╗░  
        ░╚═══██╗░░░██║░░░██╔══██║██╔══██╗  ░░████╔═████║░██╔══██║██╔══██╗░╚═══██╗  
        ██████╔╝░░░██║░░░██║░░██║██║░░██║  ░░╚██╔╝░╚██╔╝░██║░░██║██║░░██║██████╔╝  
        ╚═════╝░░░░╚═╝░░░╚═╝░░╚═╝╚═╝░░╚═╝  ░░░╚═╝░░░╚═╝░░╚═╝░░╚═╝╚═╝░░╚═╝╚═════╝░  
        
        ░██████╗████████╗░█████╗░██████╗░  ░██████╗██╗░░██╗██╗██████╗░░██████╗
        ██╔════╝╚══██╔══╝██╔══██╗██╔══██╗  ██╔════╝██║░░██║██║██╔══██╗██╔════╝
        ╚█████╗░░░░██║░░░███████║██████╔╝  ╚█████╗░███████║██║██████╔╝╚█████╗░
        ░╚═══██╗░░░██║░░░██╔══██║██╔══██╗  ░╚═══██╗██╔══██║██║██╔═══╝░░╚═══██╗
        ██████╔╝░░░██║░░░██║░░██║██║░░██║  ██████╔╝██║░░██║██║██║░░░░░██████╔╝
        ╚═════╝░░░░╚═╝░░░╚═╝░░╚═╝╚═╝░░╚═╝  ╚═════╝░╚═╝░░╚═╝╚═╝╚═╝░░░░░╚═════╝░".colorize(:light_yellow)
        puts ""
        charprint("loading starship information")
        Api.load_starships
        menu
    end

    def menu
        charprint("Here is the list of all the starships you can interact with:")
        list_starships
        puts ""
        charprint("Enter a corresponding number or type 'exit' to exit the archive")
        get_input
    end

    def help
        charprint("Here's all the help I can give you right now:")
        puts ""
        puts("Commands: \n use \"menu\" - lists the starships again \n use \"help\" - display this information about usable commands \n use \"contact\" - displays contact info to reach out about any questions, comments, or concerns to the developer of this app \n use \"exit\" or \"quit\" - shuts down and exits program running in terminal \n")
        get_input
    end

    def contact
        charprint("Creator: Wesley Beck")
        puts "You can contact him via the following information:\n"
        puts TTY::Link.link_to("GitHub", "https://github.com/wizbeck21")
        puts TTY::Link.link_to("LinkedIn", "https://www.linkedin.com/in/wesleyabeck/")
        puts ""
        get_input
    end
    
    def get_input
        input = gets.chomp
        check_input(input)
        index = input.to_i - 1
            if  input == "exit" || input == "quit"
                charprint("May the Force be with you.")
                sleep(0.3)
                charprint("Thank you for using swstarships!")

                    3.times do
                        print "."
                        sleep(0.45)
                    end
                puts ""
                charprint("Stopping".colorize(:red))
                exit
            elsif input == "menu"
                menu
            elsif input == "help"
                help
            elsif input =="contact"
                contact
            elsif check_input(input) && valid?(index)
                charprint("Hang on while we grab the data...")
                sleep(1)
                charprint("Here is the data we currently have on the #{Starship.all[index].name}:")
                puts ""
                starship_traits(index)
                charprint("To choose another ship, enter the number of the ship you want to see")
                charprint("You can Type 'menu' to see the list of starships again.")
                charprint("Or you can exit the app at any time by typing 'exit'.")
                get_input
            else check_input(input) && valid?(index) != true
                sleep(0.3)
                charprint("Invalid input. Please Try again.")
                get_input
            end
    
    end

    def valid?(index)
        if index >= 0 && index < Starship.all.length
            true
        end
    end
    def check_input(input)
        input !~ /\D/
    end


    def list_starships
        Starship.all.each.with_index(1) do |starship, index|
            puts "#{index}. #{starship.name}"
            sleep(0.1)
        end
    end


    def starship_traits(input)
        starship = Starship.all[input]
        charprint("Name: #{starship.name}")
        charprint("Manufacturer: #{starship.manufacturer}")
        charprint("Cargo Capacity: #{starship.cargo_capacity}")
        charprint("Hyperdrive Rating: #{starship.hyperdrive_rating}")
        charprint("Cost (in credits): #{starship.cost_in_credits}")
        charprint("Passengers: #{starship.passengers}")
        charprint("Max Atmosphering Speed: #{starship.max_atmosphering_speed}")
        puts ""
    end

    def charprint(string)
        string.each_char do |c|
            print c
            sleep(0.02)
        end
        puts ""
    end
    
end
