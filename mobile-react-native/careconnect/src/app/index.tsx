import { SafeAreaView, StatusBar, StyleSheet, View } from "react-native";

import { BottomNav } from "../components/home/bottom-nav";
import { AddMedicationScreen } from "../screens/add-medication-screen";
import { HighlightsScreen } from "../screens/highlight-screen";
import { HomeScreen } from "../screens/home-screen";
import { MedicationsScreen } from "../screens/medications-screen";
import { useHomeFlow } from "../hooks/use-home-flow";

export default function Index() {
  const { screen, setScreen, navState } = useHomeFlow();

  return (
    <View style={styles.phoneShell}>
      <StatusBar barStyle="light-content" />
      <SafeAreaView style={styles.safeArea}>
        {(screen === "home" || screen === "highlights") && (
          <HomeScreen onOpenHighlights={() => setScreen("highlights")} onOpenMeds={() => setScreen("medications")} />
        )}
        {screen === "medications" && <MedicationsScreen onOpenAdd={() => setScreen("add")} />}
        {screen === "add" && <AddMedicationScreen onOpenMeds={() => setScreen("medications")} />}
        {screen === "highlights" && <HighlightsScreen onClose={() => setScreen("home")} />}

        {screen !== "highlights" && (
          <BottomNav
            active={navState}
            onPress={(item) => {
              if (item === "Home") setScreen("home");
              if (item === "Meds") setScreen("medications");
              if (item === "Inbox") setScreen("home");
            }}
          />
        )}
      </SafeAreaView>
    </View>
  );
}

const styles = StyleSheet.create({
  phoneShell: {
    flex: 1,
    backgroundColor: "#cfd7e1",
    alignItems: "center",
    justifyContent: "center",
  },
  safeArea: {
    width: 390,
    height: 844,
    backgroundColor: "#f3f5f7",
    borderRadius: 30,
    overflow: "hidden",
    position: "relative",
    shadowColor: "rgba(15, 31, 52, 0.15)",
    shadowOpacity: 0.2,
    shadowRadius: 12,
    shadowOffset: { width: 0, height: 8 },
    elevation: 12,
  },
});
