class ParallelSearcher implements ParallelSearcherInterface {

    double importantData;


    @Override
    public void set(HidingPlaceSupplierSupplier supplier) {
        HidingPlaceSupplier input = supplier.get(0);

        while (input != null) {
            Thread[] threads = new Thread[input.threads()];
            // for 1
            for (int i = 0; i < threads.length; i++) {
                System.out.println("(for 1): IM STARTING NEW TREADSSS!!");
                threads[i] = new Help(input, this);
                threads[i].start();
            }
            // for 2
            for (Thread thread : threads) {
                System.out.println("(for 2) IM TRTING TO DO!!");
                try {
                    thread.join();
                } catch (Exception ignored) {
                }
            }
            System.out.println("(while) INPUT OUT === " + importantData + "====");
            input = supplier.get(importantData);
            importantData = 0;
        }
        importantData = 0;
    }

    private class Help extends Thread {
        final Object synchroDude;
        HidingPlaceSupplier input;

        public Help(HidingPlaceSupplier input, Object synchroDude) {
            this.input = input;
            this.synchroDude = synchroDude;
        }

        @Override
        public void run() {
            HidingPlaceSupplier.HidingPlace threadInput = input.get();
            while (threadInput != null) {
                synchronized (threadInput) {
                    if (threadInput.isPresent()) {
                        synchronized (synchroDude) {
                            importantData += threadInput.openAndGetValue();
                        }
                    }
                }
                threadInput = input.get();
            }
        }
    }
}