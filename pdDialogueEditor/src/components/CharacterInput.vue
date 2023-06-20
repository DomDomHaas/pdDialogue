<template>
  <v-combobox v-model="characters"
              :items="predefinedCharacters"
              :clearable="true"
              label="Characters"
              placeholder="Define characters"
              variant="underlined"
              :multiple="true"
              item-title="name"
              item-value="iconId"
              :delimiters="[',']"
              hide-details
  >
    <template v-slot:item="{ props, item, index }">
      <CharacterIcon v-bind="props"
                     :iconId="item?.raw.iconId"
                     :name="item?.raw.name"
                     :avatarChangeable="true"
                     @changeIcon="catchChangeIcon"
                     density="compact"
      ></CharacterIcon>
    </template>

    <template v-slot:selection="{ props, item, index }">
      <CharacterIcon v-bind="props"
                     :iconId="item?.raw.iconId"
                     :name="item?.raw.name"
                     density="compact"
                     closable
      ></CharacterIcon>
    </template>

    <template v-slot:no-data>
      <div class="pa-2">
        Define characters so you can assign dialogue items to them
      </div>
    </template>
  </v-combobox>

</template>

<script>
import CharacterIcon from '@/components/CharacterIcon.vue'

export default {
  name: 'CharacterSelection',
  props: {
    predefinedCharacters: {
      type: Array,
      default: () => undefined, // ['Eddie', 'Ivon', 'Malea'],
    },
  },
  computed: {
    characters: {
      get() {
        return this.predefinedCharacters;
      },
      set(value) {
        let newValue = value;
        if (value instanceof Array) {
          newValue = value[value.length - 1];
        }

        const newCharacters = [...this.predefinedCharacters];
        newCharacters.push({
          iconId: this.defaultIconId++,
          name: newValue,
        });

        this.changeChapterProperty('characters', this.predefinedCharacters, newCharacters);
      }
    },
  },
  methods: {
    catchChangeIcon({ newId, name }) {

      const newCharacters = [...this.characters];
      const charObj = newCharacters.filter((c) => c.name === name)[0] || null;

      if (charObj) {
        charObj.iconId = newId;
        this.changeChapterProperty('characters', this.characters, newCharacters);
      }

    },
    changeChapterProperty(property, oldValue, newValue) {
      this.$emit('changeChapterProperty',
        property,
        oldValue,
        newValue,
      );
    },
  },
  components: {
    CharacterIcon,
  },
  data: () => ({
    defaultIconId: 1,
  }),
};

</script>
