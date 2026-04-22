import { apiFetch } from "./api";

export type Bean = {
  id?: string;
  name: string;
  roastLevel?: string;
  origin?: string;
};

export async function getBeans(): Promise<Bean[]> {
  return apiFetch<Bean[]>("/beans", {
    method: "GET",
  });
}

export async function getBean(beanId: string): Promise<Bean> {
  return apiFetch<Bean>(`/beans/${beanId}`, {
    method: "GET",
  });
}

export async function createBean(bean: Bean): Promise<string> {
  return apiFetch<string>("/users/beans/", {
    method: "POST",
    bodyJson: bean,
  });
}

export async function updateBean(beanId: string, bean: Bean): Promise<void> {
  return apiFetch<void>(`/users/beans/${beanId}`, {
    method: "POST",
    bodyJson: bean,
  });
}

export async function deleteBean(beanId: string): Promise<void> {
  return apiFetch<void>(`/users/beans/${beanId}`, {
    method: "DELETE",
  });
}
