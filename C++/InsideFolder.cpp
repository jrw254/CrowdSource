#include <iostream>
#include <string>
#include <filesystem>

int InsideFolder(std::string_view path) {
    int files = 0;
    int folders = 0;

    try {
        if (std::filesystem::exists(path)) {
            for (const auto& entry : std::filesystem::directory_iterator(path)) {
                if (entry.is_regular_file()) ++files;
                else if (entry.is_directory() && !entry.is_symlink()) {
                    if (entry.path() != path) ++folders; 
                } 
            } 

            std::cout << "Total files: " << files << '\n';
            std::cout << "Total folders: " << folders << '\n';
        }
        else {
            std::cout << "Invalid path!\n";
                std::string path; 
    do { 
        std::cout << "Enter path: "; 
        std::cin >> path; 
        int result = InsideFolder(path); 
        if (result == -1) continue; 
        else return 0; 
    } while (true); 
            // return -1;
        }
    }
    catch (const std::filesystem::filesystem_error& e) {
        std::cout << e.what() << '\n';
        return -1;
    }
    return files + folders;
}

int main() 
{
    // Get path from user
    std::cout << "Enter path: ";
    std::string path;
    std::cin >> path;

    // Show information
    InsideFolder(path);

}