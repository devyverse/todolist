CC = gcc
CXX = g++
CFLAGS = -Wall -Wextra -Werror -g
CXXFLAGS = -Wall -Wextra -Werror -g

TARGET_EXERC := final_program

BUILD_DIR := ./build
SRC_DIRS := ./src

# Correction : SRC_DIRS (et non SRCS_DIRS) et fermeture correcte de la parenthèse
SRCS := $(shell find $(SRC_DIRS) -name '*.cpp' -or -name '*.c')

# Correction du cheminement des objets (on mappe les sources vers build/)
OBJS := $(SRCS:%=$(BUILD_DIR)/%.o)
DEPS := $(OBJS:.o=.d)

INC_DIRS := $(shell find $(SRC_DIRS) -type d)
# Correction : $(addprefix ...) avec des parenthèses
INC_FLAGS := $(addprefix -I, $(INC_DIRS))

CPPFLAGS := $(INC_FLAGS) -MMD -MP

# Étape finale : Utilisation de $(CXX) ou $(CC) selon le projet, ici liaison C++
$(BUILD_DIR)/$(TARGET_EXERC): $(OBJS)
	$(CXX) $(OBJS) -o $@ $(LDFLAGS)

# Étape de construction pour les fichiers .c
$(BUILD_DIR)/%.c.o: %.c
	mkdir -p $(dir $@)
	$(CC) $(CPPFLAGS) $(CFLAGS) -c $< -o $@

# Étape de construction pour les fichiers .cpp
$(BUILD_DIR)/%.cpp.o: %.cpp
	mkdir -p $(dir $@)
	$(CXX) $(CPPFLAGS) $(CXXFLAGS) -c $< -o $@

.PHONY: clean
clean:
	rm -rf $(BUILD_DIR)

-include $(DEPS)
