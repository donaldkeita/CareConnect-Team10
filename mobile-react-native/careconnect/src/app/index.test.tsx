import { fireEvent, render } from "@testing-library/react-native";

import Index from "./index";

describe("CareConnect user interactions", () => {
  it("opens and closes the Highlights overlay", async () => {
    const { getByRole, getByText, queryByText } = await render(<Index />);

    await fireEvent.press(getByRole("button", { name: "Open highlights" }));
    expect(getByText("Today's Highlights")).toBeTruthy();
    expect(getByRole("button", { name: "Close highlights" })).toBeTruthy();

    await fireEvent.press(getByRole("button", { name: "Close highlights" }));
    expect(queryByText("Today's Highlights")).toBeNull();
  });

  it("navigates from Home to Medications and then Add Medication", async () => {
    const { getByRole, getByText } = await render(<Index />);

    await fireEvent.press(getByRole("button", { name: "Meds" }));
    expect(getByText("Medications")).toBeTruthy();

    await fireEvent.press(getByRole("button", { name: "Add medication" }));
    expect(getByText("Add Medication")).toBeTruthy();
    expect(getByText("Medication details")).toBeTruthy();
  });

  it("returns to Medications when saving or backing out of the add form", async () => {
    const { getByRole, getByText } = await render(<Index />);

    await fireEvent.press(getByRole("button", { name: "Meds" }));
    await fireEvent.press(getByRole("button", { name: "Add medication" }));
    await fireEvent.press(getByRole("button", { name: "Save medication" }));
    expect(getByText("Medications")).toBeTruthy();

    await fireEvent.press(getByRole("button", { name: "Add medication" }));
    await fireEvent.press(getByRole("button", { name: "Back to medications" }));
    expect(getByText("Medications")).toBeTruthy();
  });
});
