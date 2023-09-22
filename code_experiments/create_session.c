#include <stdio.h>
#include <gpac/filters.h>

int main(int argc, const char** argv) {

    GF_FilterSession *session = gf_fs_new_defaults(0u);
    if (session == NULL)
    {
        fprintf(stderr, "Failed to create GPAC session\n");
        return EXIT_FAILURE;
    }

    GF_Err gf_err = GF_OK;
    GF_Filter *filter_ptr = gf_fs_load_filter(session, "", &gf_err);

    const char* err_str = gf_error_to_string(gf_err);
    printf("Error code %d: %s\n", gf_err, err_str);


    if (filter_ptr == NULL) {
        printf("Filter ptr NULL\n");
    } else {
        printf("Filter loaded\n");
    }

    return EXIT_SUCCESS;
}