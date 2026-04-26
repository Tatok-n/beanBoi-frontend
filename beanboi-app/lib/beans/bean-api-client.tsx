import { clientApiFetch } from "../api-client";
import { Bean } from "./types/bean";


export async function createBean(bean: Bean): Promise<string> {
  return clientApiFetch<string>("/users/beans/", {
    method: "POST",
    bodyJson: bean,
  });
}

export async function updateBean(beanId: string, bean: Bean): Promise<void> {
  return clientApiFetch<void>(`/users/beans/${beanId}`, {
    method: "POST",
    bodyJson: bean,
  });
}

export async function deleteBean(beanId: string): Promise<void> {
  return clientApiFetch<void>(`/users/beans/${beanId}`, {
    method: "DELETE",
  });
}


const exampleBeans: Bean[] = [
  {
    id: "123",
    name: "TestBean",
    roaster: "Faro",
    process: "Black Honey",
    origin: "Your mom",
    roastLevel: 2,
    altitude: 1000,
    price: 0,
    timesPurchased: 0,
    uid: "",
    isActive: true,
    tastingNotes: "",
  },
  {
    id: "456",
    name: "Tanzania peaberry",
    roaster: "Faro",
    process: "Washed",
    origin: "Tanzania",
    roastLevel: 1,
    altitude: 1001,
    price: 0,
    timesPurchased: 2,
    uid: "",
    isActive: true,
    tastingNotes: "",
  },
]

export const debug = false;
