import { describe, expect, it, test } from "vitest";

const accounts = simnet.getAccounts();
const address1 = accounts.get("wallet_1")!;

describe("example tests", () => {
  it("ensures simnet is well initialised", () => {
    expect(simnet.blockHeight).toBeDefined();
  });

  // it("shows an example", () => {
  //   const { result } = simnet.callReadOnlyFn("counter", "get-counter", [], address1);
  //   expect(result).toBeUint(0);
  // });
});

describe("Testing start", () => {
  test("Allows the contract owner to initialise the vault", () => {
    const startResponse = simnet.callPublicFn(
      "multisig-vault",
      "start",
      [memberList, Cl.uint(votesRequired)],
      deployer,
    );

    expect(startResponse.result).toBeOk(Cl.bool(true));
  });

  test("Does not allow anyone else to initialise the vault", () => {
    const startResponse = simnet.callPublicFn(
      "multisig-vault",
      "start",
      [memberList, Cl.uint(votesRequired)],
      wallet1,
    );

    expect(startResponse.result).toBeErr(Cl.uint(100));
  });

  test("Cannot start the vault more than once", () => {
    const startResponse1 = simnet.callPublicFn(
      "multisig-vault",
      "start",
      [memberList, Cl.uint(votesRequired)],
      deployer,
    );

    const startResponse2 = simnet.callPublicFn(
      "multisig-vault",
      "start",
      [memberList, Cl.uint(votesRequired)],
      deployer,
    );

    expect(startResponse1.result).toBeOk(Cl.bool(true));
    expect(startResponse2.result).toBeErr(Cl.uint(101));
  });

  test("Cannot require more votes than members", () => {
    const startResponse = simnet.callPublicFn(
      "multisig-vault",
      "start",
      [members, Cl.uint(members.list.length + 1)],
      deployer,
    );
    expect(startResponse.result).toBeErr(Cl.uint(102));
  });
});
