#include "ng.h"
#include  <sys/types.h>
#include <sys/stat.h>
#include <unistd.h>


int main(int argc, char *argv[]) {
    char *curr_dir;

    curr_dir = ".";
    traverse_files(curr_dir);
}

int traverse_files(char *directory) {
    dirpaths = ls(directory)
    for path in dirpaths {
        if (is_file(path) && is_note(path)) {
            record_connections(path);
        } else if is_directory(path) {
            traverse_files(path);
        }
    }
    return 0;
}

int record_connections(char *path) {
    parse_md(...)
}

int ls(char *directory, char *dirpaths[]) {

}

int is_note(char *path) {

}

int is_file(char *path) {
}

int is_directory(char *path) {
}
