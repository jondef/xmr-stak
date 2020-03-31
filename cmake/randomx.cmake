
list(APPEND HEADERS_CRYPTO
#    ${PROJECT_SOURCE_DIR}/xmrstak/backend/cpu/crypto/rx/Rx.h
#    ${PROJECT_SOURCE_DIR}/xmrstak/backend/cpu/crypto/rx/RxAlgo.h
#    ${PROJECT_SOURCE_DIR}/xmrstak/backend/cpu/crypto/rx/RxCache.h
#    ${PROJECT_SOURCE_DIR}/xmrstak/backend/cpu/crypto/rx/RxConfig.h
#    ${PROJECT_SOURCE_DIR}/xmrstak/backend/cpu/crypto/rx/RxDataset.h
#    ${PROJECT_SOURCE_DIR}/xmrstak/backend/cpu/crypto/rx/RxVm.h
)

list(APPEND SOURCES_RANDOMX
    ${PROJECT_SOURCE_DIR}/xmrstak/backend/cpu/crypto/randomx/aes_hash.cpp
    ${PROJECT_SOURCE_DIR}/xmrstak/backend/cpu/crypto/randomx/allocator.cpp
    ${PROJECT_SOURCE_DIR}/xmrstak/backend/cpu/crypto/randomx/argon2_core.c
    ${PROJECT_SOURCE_DIR}/xmrstak/backend/cpu/crypto/randomx/argon2_ref.c
    ${PROJECT_SOURCE_DIR}/xmrstak/backend/cpu/crypto/randomx/blake2_generator.cpp
    ${PROJECT_SOURCE_DIR}/xmrstak/backend/cpu/crypto/randomx/blake2/blake2b.c
    ${PROJECT_SOURCE_DIR}/xmrstak/backend/cpu/crypto/randomx/bytecode_machine.cpp
    ${PROJECT_SOURCE_DIR}/xmrstak/backend/cpu/crypto/randomx/dataset.cpp
    ${PROJECT_SOURCE_DIR}/xmrstak/backend/cpu/crypto/randomx/instructions_portable.cpp
    ${PROJECT_SOURCE_DIR}/xmrstak/backend/cpu/crypto/randomx/randomx.cpp
    ${PROJECT_SOURCE_DIR}/xmrstak/backend/cpu/crypto/randomx/reciprocal.c
    ${PROJECT_SOURCE_DIR}/xmrstak/backend/cpu/crypto/randomx/soft_aes.cpp
    ${PROJECT_SOURCE_DIR}/xmrstak/backend/cpu/crypto/randomx/superscalar.cpp
    ${PROJECT_SOURCE_DIR}/xmrstak/backend/cpu/crypto/randomx/virtual_machine.cpp
    ${PROJECT_SOURCE_DIR}/xmrstak/backend/cpu/crypto/randomx/virtual_memory.cpp
    ${PROJECT_SOURCE_DIR}/xmrstak/backend/cpu/crypto/randomx/vm_compiled_light.cpp
    ${PROJECT_SOURCE_DIR}/xmrstak/backend/cpu/crypto/randomx/vm_compiled.cpp
    ${PROJECT_SOURCE_DIR}/xmrstak/backend/cpu/crypto/randomx/vm_interpreted_light.cpp
    ${PROJECT_SOURCE_DIR}/xmrstak/backend/cpu/crypto/randomx/vm_interpreted.cpp
)

if(CMAKE_C_COMPILER_ID MATCHES MSVC)
    enable_language(ASM_MASM)
    list(APPEND SOURCES_RANDOMX
         ${PROJECT_SOURCE_DIR}/xmrstak/backend/cpu/crypto/randomx/jit_compiler_x86_static.asm
         ${PROJECT_SOURCE_DIR}/xmrstak/backend/cpu/crypto/randomx/jit_compiler_x86.cpp
         ${PROJECT_SOURCE_DIR}/xmrstak/backend/cpu/crypto/common/VirtualMemory_win.cpp
        )
elseif(CMAKE_SIZEOF_VOID_P EQUAL 8)
    list(APPEND SOURCES_RANDOMX
         ${PROJECT_SOURCE_DIR}/xmrstak/backend/cpu/crypto/randomx/jit_compiler_x86_static.S
         ${PROJECT_SOURCE_DIR}/xmrstak/backend/cpu/crypto/randomx/jit_compiler_x86.cpp
         ${PROJECT_SOURCE_DIR}/xmrstak/backend/cpu/crypto/common/VirtualMemory_unix.cpp
        )
    # cheat because cmake and ccache hate each other
    set_property(SOURCE ${PROJECT_SOURCE_DIR}/xmrstak/backend/cpu/crypto/randomx/jit_compiler_x86_static.S PROPERTY LANGUAGE C)
endif()

add_library(xmr-stak-randomx
    STATIC
    ${SOURCES_RANDOMX}
)
set_property(TARGET xmr-stak-randomx PROPERTY POSITION_INDEPENDENT_CODE ON)